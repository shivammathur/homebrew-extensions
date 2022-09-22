# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT82 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.49.0.tgz"
  sha256 "dfcd402553a53aac4894b65c77e452c55c93d2c785114b23c152d0c624edf2ec"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_monterey: "322dab26eb0df7dee2ca3ebe160e1d38aaa4342d79b3db68a17443f66703ae8d"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "0d51daed9317ba47a4801654df1c9d31d940affe5ceaca7ad309086a40945339"
    sha256 cellar: :any_skip_relocation, monterey:       "77c7c0e27ae9e261bc8a92094f1c4e2cda174357654bf03f82610e630374eccf"
    sha256 cellar: :any_skip_relocation, big_sur:        "a7705b6d422311b446309fe099de068e94e01056eebf622487a72fe831442917"
    sha256 cellar: :any_skip_relocation, catalina:       "e2400c53b7a27cedf21fcdc93eee97ae4822ae0a68ea8ba18ed988377fcff7bf"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "8cd13306cf90997c33d049bfe92f7c3c723bde71d0a8abbb162e051c7c698a73"
  end

  depends_on "grpc"

  def install
    Dir.chdir "grpc-#{version}"
    patch_spl_symbols
    safe_phpize
    system "./configure", "--enable-grpc"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
