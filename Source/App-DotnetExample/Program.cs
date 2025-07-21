using LoggingComponent;

object data = new {
    message = "Json object",
    error = false,
    integer = 1324
};

Logger.Log("This is a string log.");
Logger.Log(data);