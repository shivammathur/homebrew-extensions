# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT74 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.65.1.tgz"
  sha256 "78d14477f19793ac7b617bce8f8795b7f6b8888f338316f96eade83156e58e7a"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "9815076541e44186150aac62a7f31b26e3af73e6f31b54f1ef382a0a5ccf9d8e"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "f9574602573baf91f01cccc64ca6368f5ef66f3463d7c3452675aaf71393f207"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "3939843768f5f181e7105f14ca4aa57dac232964bbc019b41255a0a8ef21a64f"
    sha256 cellar: :any_skip_relocation, ventura:        "9ffd633554b402d6921488e21249a49eb96e94be747d3e9d84e45eef1715470e"
    sha256 cellar: :any_skip_relocation, monterey:       "cf1c1f89ff82543208ae35bae07aa48777dbb90665409cf6d02af3537a884540"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "5ae144dcc5b5637a9cf81944b1a0bb5927d3fb17b5deeaafd7aa0ef48014f48b"
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
