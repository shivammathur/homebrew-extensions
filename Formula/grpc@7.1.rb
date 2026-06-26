# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT71 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.81.1.tgz"
  sha256 "3c9086743a29bda3b5bd323e31f9c6da6e04900288ab37f0da1df8859a2ee8f5"
  head "https://github.com/grpc/grpc.git", branch: "master"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/grpc/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "f53c327fd2fcedb1a9d2d21414c0fb28d2b9cba8873c7021cb83e259ca73a783"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "f3e59cb231baf746054e7830cd6b04693975a004cb4fa9a8658c9710110d5166"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "db94c98573a8bdc29a8d97f11cea398d695ef80f02aca9aa501a9e7a983e68ea"
    sha256 cellar: :any_skip_relocation, sonoma:        "5453f66d0022e00a47972fd32dcb5a7c6df58ef7213350cece05f3d2fb347ee6"
    sha256 cellar: :any,                 arm64_linux:   "64da96034fe9f428869e2cefef975c3c9bae914ab38c1a5180b1f3d127d6dec7"
    sha256 cellar: :any,                 x86_64_linux:  "124c9850645dc4baa8021a944ea33e287f69bbe179e3ba0f488c5d81ce2e77cb"
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
