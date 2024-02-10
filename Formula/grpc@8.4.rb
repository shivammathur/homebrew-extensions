# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT84 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.61.0.tgz"
  sha256 "7efeff25faac9b8d92b3dc92e6c1e317e75d40a10bdc90bb3d91f2bf3aadf102"
  head "https://github.com/grpc/grpc.git", branch: "master"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "c039f5cb5db2d50d5079d757a4f7c7188508721d49a3676496ac8675203f0766"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "06f2b5939db4ea0568d8a591d9cfc0ea78177e3597bd049832dc02faa956056d"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "032a6681400c6dd91bbb2539ebe002c911cee37628e5d0f07b5938530f7ddfbb"
    sha256 cellar: :any_skip_relocation, ventura:        "183c74abbe2ab8358367d141b0da33b67f1c02dd0ac3a7562c264efa2e556921"
    sha256 cellar: :any_skip_relocation, monterey:       "4390618e5d55d37455c075ea4fa9a06f2a507c39b908d6c338054d97d3ea08b7"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "ea875cbff16fbab6c9635c93117a2842aacce86620a5ddd7ae67fd28ba274767"
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
