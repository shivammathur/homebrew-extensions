# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT84 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.72.0.tgz"
  sha256 "715fe230c0b185968e92f8f752d61a878f9eb5346873848e47ff65d0af6947dc"
  head "https://github.com/grpc/grpc.git", branch: "master"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/grpc/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "23d20823379656445df100a45e812fc93da785ad8deb83eaa7e370091b32c8fa"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "e141f271f26e978ba6eb2b58b105c33259817b343b135ccd2226c119541e74d1"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "8d276d54c53be8342f07b97288c66b0d9de9f3d18188303d0ee8495a5a2c2823"
    sha256 cellar: :any_skip_relocation, ventura:       "5ed6c31244735f607dc1fc9d7a97798b2b0601c168901fb49201df40e987fdb0"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "9cb931b5053183ce1b5e7cec32ea7d365f64e7c6b544c5ee1d565d8182b84231"
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
