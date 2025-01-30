# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT81 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.69.0.tgz"
  sha256 "85ef59edd3517b377736c49a73799ead4729a82b960474b8842c9f89d2fbf222"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "6f283486f35fe09bb1127407c861b0c3db5079a748a150f7f70a4488400c11e2"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "e2d950b3630015d05b60d7dcf854e5a696fc2022b2ba89ce2dc66e9f5e06d34c"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "180d1b25419d6b116ed32bf57492c45df1ce505a891cace1385940eb950dd718"
    sha256 cellar: :any_skip_relocation, ventura:       "38ab9b23df155241be91b41a38d745512302435b102d447c26910101b1731278"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "9b00fae6ceca0a4b775524a5bd0f5617f11c57939b88b9916ef14d0d8e57709f"
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
