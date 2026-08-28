# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT74 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "3cc9a5e66a40dc4da8a70ec5c106e4288135da74241d0454a61e72e7b929506e"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "fa7567157cbb4a5a9a4ad0c70526a400e534553556401145e1d0198d1874c634"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "d2ac506a66dc53075950d4b7180666a17d01b06b9e2478255fdec6601448db4b"
    sha256 cellar: :any,                 arm64_linux:   "5e18715d354c2e27c8c08548057370160adc9d5c32ed5bb8dd32ca4dd07e7b5d"
    sha256 cellar: :any,                 x86_64_linux:  "3e8c863115a2a1595ffe68ce64e2642503039b3e889fd78290a6b66c5e4e75f1"
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
