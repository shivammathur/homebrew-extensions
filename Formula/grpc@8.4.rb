# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT84 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.60.0.tgz"
  sha256 "171f490b5426de76b479036c95d4c1ca44bb1a3fb42999e938d2c59fcbceed32"
  head "https://github.com/grpc/grpc.git", branch: "master"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "8ebb73fff26bec2ab4428aae200a53eb4a31a7e8151b86ef5d9fdb17dd2afd7f"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "0af7e68ad5315fa5af370820aadc7a29ffbc86585c9e3325150f86889fc1b83e"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "0647ecadaa3c43bdecab577a55f52206b35176dd5308aa5156f15f3717d174c8"
    sha256 cellar: :any_skip_relocation, ventura:        "8bdb73c1c5b7972163fea6c7d77524510deb3cd4646d56e08a6fb0caad7e1ece"
    sha256 cellar: :any_skip_relocation, monterey:       "c709ae789af8d3a920d7195517d748002a0efc596914729385321ff3320726a3"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "8ba35fe8ca8ad817b05a990467914a5717f7262e7214b9416254c5bfe56ec7cb"
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
