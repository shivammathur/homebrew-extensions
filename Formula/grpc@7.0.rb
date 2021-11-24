# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT70 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.42.0.tgz"
  sha256 "a7b9092534555ea4ea0ea79c1333afd088569eb5865b941a4a610504e387683a"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "a03afa99344e0b900c57428d018ffdce94414d4612346d25431e6024497b08ea"
    sha256 cellar: :any_skip_relocation, big_sur:       "9fd19f89711366467a0d29828c70e479fb69d25d6d0f781a9af6ff501db4e96f"
    sha256 cellar: :any_skip_relocation, catalina:      "e194770a80018828a96fa1254bf2b092566adffcbd3bef5f0dbd54cfcf40b6bb"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "70788a6fb5edaf5a94ac4be10dd23469a94d5334075366820ec2c585e0c70aff"
  end

  depends_on "grpc"

  def install
    Dir.chdir "grpc-#{version}"
    safe_phpize
    system "./configure", "--enable-grpc"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
