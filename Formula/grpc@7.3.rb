# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT73 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.81.1.tgz"
  sha256 "3c9086743a29bda3b5bd323e31f9c6da6e04900288ab37f0da1df8859a2ee8f5"
  head "https://github.com/grpc/grpc.git", branch: "master"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/grpc/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "9ae9b68c591df105f2c6adb8a55976c0c08bf5fd51a9242215901943063a54f6"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "cfb037264d68a56b704f30673f95bca5136b78bb125d607420c2580e7c017069"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "57e6ee7cdb12c7e69b8e095d90a56930133b05490c949f326622ba7f3aab8182"
    sha256 cellar: :any_skip_relocation, sonoma:        "b202491e74aac452fb1f312e52a375b5a51c5662e25d3b7edc8c9f4b2d56f0fd"
    sha256 cellar: :any,                 arm64_linux:   "353f96fa42a4e9abb848b20ba2af4c1b7170e2a2dd6b312a0f8143da2d360b3c"
    sha256 cellar: :any,                 x86_64_linux:  "a46a086688f2e976cb960a649173b6243b1edb21cc428e72dd3d65e665c30937"
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
