# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT74 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.54.0.tgz"
  sha256 "5ad3c1a046290f901771fc3f557db6c5bdd4208e157f42a0ab061cf10ac0dfa9"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "01247686f3423ce3683b9ee5fc6330bbcff3d7caba71f6a18b028c75f478f009"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "8245c21d3c36990af8d36e4fa8d15c37d0cce654062808f34b51873e2d61ef4e"
    sha256 cellar: :any_skip_relocation, monterey:       "f900944cf2640828e567ddf826a50b429aad8dda4082d1acad5a02347091be85"
    sha256 cellar: :any_skip_relocation, big_sur:        "f4a8bc5dbe0a205952b14750443bff9e45a664203ed717f382a5070ca94c7307"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "ea84bb58cb4ce905b34ad03146917ed456e033ab532e6984f5e8cef3f45cd649"
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
