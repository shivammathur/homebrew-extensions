# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT83 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.62.0.tgz"
  sha256 "ceabf3c564cd3d61ca7a9a06ebdde777322e50701a454f1c5d8a5291afe59302"
  head "https://github.com/grpc/grpc.git", branch: "master"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "7f1aa8142cf082f46b2f8c0caf3e8e6679134f67aff26f3c06ab87a0e1a9b732"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "2a81bcf116f96f606380ddfc65f969d272c4ec7731ea1290b118e42364e015c7"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "9007228875d605a80c958f71e7f4d74c61302596ebf2c9455dc05ad85de44407"
    sha256 cellar: :any_skip_relocation, ventura:        "95a8cc7694e0142a5e96f586c9e55551e1780b63535b802951b1d9d5c5d2c7a2"
    sha256 cellar: :any_skip_relocation, monterey:       "96eca43c6c415d1ea4caff84f392e97f18739d1f0e22bf9797fdf477a431ee81"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "227fe5ae0feb30c9f96ca35f05ca4601e1842bbae1b00e7527a3487a63eadfc4"
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
