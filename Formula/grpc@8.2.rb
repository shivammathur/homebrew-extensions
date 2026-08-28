# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT82 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "7024c413e90418421369c7be3f4fd66ea06fff251ba99bcf5d26abf8cc9fea25"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "f742cadeea4d389721c532a8cdae77d7e501be8d5a429411cd65449d46251618"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "8f5c30d91fd89c833187e0ae97818173a9d941d00e5456b26f66b026478c0e7b"
    sha256 cellar: :any_skip_relocation, sonoma:        "2444c64b531b3fa00b94597247e8638412e543e041ed1309d3d7b9b3341fdc45"
    sha256 cellar: :any,                 arm64_linux:   "e665a2dd015f4c45a6d6fa2143057d7b04a9878871d444c380dfb6682a1cfd67"
    sha256 cellar: :any,                 x86_64_linux:  "8bd5552773adcbe34b1f9556f1367aa87c0d0303932c15dd681565f764fa4e72"
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
