# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT71 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.51.1.tgz"
  sha256 "a8a79bf27bceeb8088c2a3a5a76c1146bbbd3e8d7a8a13e44ddbcfd715213ba9"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "9bf1c78f52abfc4b0e1ac6a12d053e7b869230fb8a2ffc65a52eecdf236a4864"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "cac2b3193d8677c3fa4b54aa755b0119c1f97c3ba582467a358e92afad289db7"
    sha256 cellar: :any_skip_relocation, monterey:       "764b03dbe4909d3652a25f1f366364c554a5cfec45c52e8712b59eb4006aa104"
    sha256 cellar: :any_skip_relocation, big_sur:        "e47b420abb10a4a5c1af352c7e69639c59265a2948dc8f2b6f8134e4441a0929"
    sha256 cellar: :any_skip_relocation, catalina:       "0ff0cdd4eb0feec954d874566ea42545c224cb62e44515bbd6c047d1dad35a3b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "f407a8e31639819ec2455d6d8a18383d14a442a2bba2d694cf6e86b2a7ca4e03"
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
