import os
import csv

poll_csv = os.path.join("Resources", "election_data.csv")


def electionresults():
    with open(poll_csv, newline='') as csvfile:
        csvreader = csv.reader(csvfile, delimiter=",")

        # variables
        candidates = []
        total_votes = 0
        percent_votes = []
        totalvotes_candidate = []
        winner = ""

        next(csvreader, None)
        for candidate in csvreader:
            if candidate[-1] not in candidates:
                candidates.append(candidate[-1])
                totalvotes_candidate.append(1)
            else:
                index = candidates.index(candidate[-1])
                totalvotes_candidate[index] += 1

            total_votes += 1

        for votes in totalvotes_candidate:
            percentages = "{0: .3f}".format(round((votes/total_votes)*100, 2))
            percent_votes.append(percentages)

        winner_index = percent_votes.index(max(percent_votes))
        winner = candidates[winner_index]

        analysis = ''
        analysis += 'Election Results \n-------------------------\n'
        analysis += 'Total votes: ' + \
            str(total_votes) + '\n-------------------------\n'
        analysis += str(candidates[0]) + ': ' + str(percent_votes[0]) + \
            '% ' + '(' + str(totalvotes_candidate[0]) + ')\n'
        analysis += str(candidates[1]) + ': ' + str(percent_votes[1]) + \
            '% ' + '(' + str(totalvotes_candidate[1]) + ')\n'
        analysis += str(candidates[2]) + ': ' + str(percent_votes[2]) + \
            '% ' + '(' + str(totalvotes_candidate[2]) + ')\n'
        analysis += str(candidates[3]) + ': ' + str(percent_votes[3]) + \
            '% ' + '(' + str(totalvotes_candidate[3]) + ')\n'
        analysis += '-------------------------\nWinner: ' + str(winner)
        analysis += '\n-------------------------'

        print(analysis)

    output_file = os.path.join("Analysis", "ElectionResults.txt")

    with open(output_file, 'w') as text_file:
        text_file.write(analysis)
        text_file.close()


def main():
    electionresults()


main()
