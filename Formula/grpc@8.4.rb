# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT84 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.58.0.tgz"
  sha256 "083e6460e111cc09a12f749329eac1bb40b21ec728a10230f8942111500625f9"
  head "https://github.com/grpc/grpc.git", branch: "master"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_monterey: "7b509331cacf803e6974ea38132a33465e880e415fa581804b01c422b5f68c73"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "eb7d50cf5e287a7dea74dff6d11974bb864aa54b5d0ef024a0de45077b1ff3cc"
    sha256 cellar: :any_skip_relocation, ventura:        "7087e5e49609230f9a5b2825f1d12188f9f9e2506ed9d397ab08e6449916f9ce"
    sha256 cellar: :any_skip_relocation, monterey:       "5ad120b785fd9c0e61681db000186607e3decfe220741cb160f9cd9570d3c6f6"
    sha256 cellar: :any_skip_relocation, big_sur:        "4447006ef96fd5c172cc95f1bac260640a5e013e0e9adb815e17d23656225cfb"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "4521a01db313654d3ed396186ba6bd22aa5a1ab2df034be5b85a72327044c7c3"
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
