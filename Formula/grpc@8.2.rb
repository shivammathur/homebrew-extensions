# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT82 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.61.0.tgz"
  sha256 "7efeff25faac9b8d92b3dc92e6c1e317e75d40a10bdc90bb3d91f2bf3aadf102"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "12ef38b0ff1463e0989dad2cb0c42520cadad94e7e58449f7c739469adc149a4"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "df1b730df17d14b6ec6787bcdb8ba8b349c13edf5f41ebee75db042a878bc235"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "53874825ea898896fa9a61f44e5006d14f0ca9b4231b35018b94a8c275e12a96"
    sha256 cellar: :any_skip_relocation, ventura:        "69fda2c23c87487a4a43877a58b9bd1429920be0e13a2a81a37f8e1f822b4dd6"
    sha256 cellar: :any_skip_relocation, monterey:       "e0ca06bcb8efb560da1e385faf49c2d7bfd19be1714187790d78ff72870f81d6"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "00bc74fdaf22f0f90f2e57b669b21484ad5f0a4f19401dd8deea0702cb50ad9f"
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
