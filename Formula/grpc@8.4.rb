# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT84 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.65.1.tgz"
  sha256 "78d14477f19793ac7b617bce8f8795b7f6b8888f338316f96eade83156e58e7a"
  head "https://github.com/grpc/grpc.git", branch: "master"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "f005c4a468ad0fa97d14d54caaaac0024b0132d264b05ee6b65c70eedca01171"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "c6c36ad39796a982919225ea0b49040632ef71245643c34bb3c0122ef6c654d0"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "10922cbd306ab397ebe903909d5ca1eeee87a606a7c9e6b211b1cc496f470414"
    sha256 cellar: :any_skip_relocation, ventura:        "f2b7daa57b4f2810ad176f1b23fa2d3adf8a48fd8f1dc5df6b6cee8de95732a0"
    sha256 cellar: :any_skip_relocation, monterey:       "334667b973ae59332f10c52c81c9befbc40fa14c0d048752e9c1f0907c2d876f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "c3b2fbc167fd1cea077d569ffdb6653a869805f3ca0e0b4c64609421b5f7d8ed"
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
