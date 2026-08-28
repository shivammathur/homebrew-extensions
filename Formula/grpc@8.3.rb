# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT83 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.83.1.tgz"
  sha256 "cb06519b1382f57ba6f5358504cb37e933d5a5892553300877fd4f3b04cf0560"
  head "https://github.com/grpc/grpc.git", branch: "master"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/grpc/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "533e6ccfce2ead61f45028551688b67aff56922a8cfb8a7abe9560a334d273bd"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "6d9e7c66f22871dbcb80cd1c0a0a7fd121f044355831f21f492329f7e7d31c53"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "8df02349be4a50c3d1854ca140837630cc6eb1c1e7494e642301f474f127c5f5"
    sha256 cellar: :any,                 arm64_linux:   "adf69759268107abdc66301fef030ec3ba277caf8a0e4cdf40d033741b6a0e33"
    sha256 cellar: :any,                 x86_64_linux:  "a3c31085ceca0a4665808fd9a82425a6ea55c6a5d3eaafa219ad315c7eafd898"
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
