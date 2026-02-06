# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT82 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.78.0.tgz"
  sha256 "c846ac9164930897fea9c55bad52aeb9f99a03cce64e694bd80f781c59baa0a8"
  head "https://github.com/grpc/grpc.git", branch: "master"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/grpc/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "1ea9cafaf8e03e8cb5015838bcd19a06b557a26d491390af9529f3fcf43a1cc3"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "3ab5b9a0a857d61dd9046f1cd9f573559e4ab62317d53a4e7cdf67a462fa4875"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "7e1d476c20800cdd32a92005fd57d47bfd01e9c6e6eaab42226cce256461bf6d"
    sha256 cellar: :any_skip_relocation, sonoma:        "6ab8dd4d076a7d808e978316266135e0a37ba2af5a7c082f1812e24301b20564"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "bc06cb47616d0c87f8161ed13738eeabbce192ae12278cf0b7806cee5c67134a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "8de828da1566c0efb9206276a682ce77b6a1af8070389f7c64136372c02b6307"
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
