# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT80 < AbstractPhp80Extension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.35.0.tgz"
  sha256 "d8de1ad5df0bc424699a44133141d9d9c936d3803ae01e5510350590b8c1e4ae"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://dl.bintray.com/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "bb4508bb01f7f47d0398f4039d798bc64dea70835d980cee442280d48f0043cc"
    sha256 cellar: :any_skip_relocation, big_sur:       "1caf261e23192e2cc52799a8fcc78c4dec4ad94dc981a6891b7e792c93a951fa"
    sha256 cellar: :any_skip_relocation, catalina:      "32413025aa0fad5870f646325994386fa69f8dabf64a1d9f62e0d20089d0874a"
  end

  depends_on "grpc"

  def install
    Dir.chdir "grpc-#{version}"
    safe_phpize
    system "./configure", "--enable-grpc"
    system "make"
    prefix.install "modules/#{module_name}.so"
    write_config_file
  end
end
