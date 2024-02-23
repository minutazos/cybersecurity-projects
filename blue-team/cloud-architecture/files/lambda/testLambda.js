exports.handler = async (event, context) => {
	context.succeed(`Hello World + ${process.env.ENV_NAME}`);
};