# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT74 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.43.0.tgz"
  sha256 "f4b41a6398666221fa03f7e01d2591b4b0e32aaf1aeca52810e6ef0c4a16d055"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "fdbfd51b3105d693092aa945fd2478ad21955ffd40ee0d844b1c61f9b1b16773"
    sha256 cellar: :any_skip_relocation, big_sur:       "27c25ec2609e00df03f288758609fc9136053538611196f042660b63d2745c0b"
    sha256 cellar: :any_skip_relocation, catalina:      "5713da18c40b514718042bafc826939840e587a795d3382c6b7233940e2e224f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "7da4af31a4632f86a7c5f4a262737e04ca470387c6d98305a7fb626de086efa1"
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
