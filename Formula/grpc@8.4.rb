# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT84 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.62.0.tgz"
  sha256 "ceabf3c564cd3d61ca7a9a06ebdde777322e50701a454f1c5d8a5291afe59302"
  head "https://github.com/grpc/grpc.git", branch: "master"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "7eda6e79d35240eb95971578dd6472fdb010099b0d9c932db5875897dc6b3974"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "6763897a7d70e81834390edc0e516d7e2cad980feaf9f9957efdd4d25d014f3f"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "ebef5a99452179e557c373247c588b0b6c8bb057fcd440f02c141d646c10f4f0"
    sha256 cellar: :any_skip_relocation, ventura:        "d18ab7926ffd18539e2da63c7ece1528c0d6cab04b44a6d10be5e9252bb0d767"
    sha256 cellar: :any_skip_relocation, monterey:       "5671f2c91bc580a4388536e556aabb4b4964ef4ac2157de349077da7c01fc150"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "1df1f52216fe7f6e8844e4e31812331e66fda4448a3f42f227f4277dcd5d7868"
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
