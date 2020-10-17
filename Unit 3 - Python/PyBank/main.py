# dependencies
import csv
import os

# filepath
path = os.path.join("Resources", "budget_data.csv")

# define analysis function and variables


def financial_analysis():
    with open(path, newline='') as csvfile:
        data = csv.reader(csvfile, delimiter=',')
        month_number = 0
        previous_value = 0
        current_value = 0
        average = 0
        net_total = 0
        greatest_inc = 0
        greatest_dec = 0

        next(data, None)

        for i in data:
            month_number += 1
            profit_loss = int(i[-1])
            net_total += profit_loss

            current_value = profit_loss
            if month_number > 1:
                change = current_value - previous_value
                average += change

                if change > greatest_inc:
                    greatest_inc = change
                    greatest_inc_month = i[0]

                if change < greatest_dec:
                    greatest_dec = change
                    greatest_dec_month = i[0]

            previous_value = current_value

# print output adn save in folder
        analysis = ''
        analysis += 'Financial Analysis \n----------------------------\n'
        analysis += 'Total Months:' + str(month_number) + '\n'
        analysis += 'Total: $ ' + str(net_total) + '\n'
        analysis += 'Average Change: $' + \
            str((round(average/(month_number - 1), 2))) + '\n'
        analysis += 'Greatest Increase in Profits: ' + \
            greatest_inc_month + ' ($' + str(greatest_inc) + ')\n'
        analysis += 'Greatest Decrease in Profits: ' + \
            greatest_dec_month + ' ($' + str(greatest_dec) + ')'

        print(analysis)

        output_file = os.path.join("Analysis", "PyBank.txt")

        with open(output_file, 'w') as text_file:
            text_file.write(analysis)
            text_file.close()

# run analysis function


def analysis():
    financial_analysis()


analysis()
