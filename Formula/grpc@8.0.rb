# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT80 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.61.0.tgz"
  sha256 "7efeff25faac9b8d92b3dc92e6c1e317e75d40a10bdc90bb3d91f2bf3aadf102"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "51b2632270386ad3a687bf2e5982fea71c4804925db8b320b516b4345a59d64e"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "8e135c2d5c5debcb92aa246f3d540d80e8179f36a0ef204f79cff51d0cad80c9"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "0ee5408405b9bfb96a094d5839cff8818476b87737ec367a90433629320223cf"
    sha256 cellar: :any_skip_relocation, ventura:        "b0d8cefe2ea5ae169578eeb5f1ea09606b7c09a41a3d37a4668346178870d574"
    sha256 cellar: :any_skip_relocation, monterey:       "6b58c8559527e90b1a17b4f71b956b65a85abc9b619f3e20351f4d4d443f5fea"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "a343183acbd049acd1630741bbefa2c31851f40dd5e3d478eafcac404d6615f0"
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
