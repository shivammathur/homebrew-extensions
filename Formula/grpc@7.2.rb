# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT72 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.83.0.tgz"
  sha256 "b12c7e0e048df728a4f2c513aeaa78ae18ad5c3ab3b607eeae398e0e1bab12ea"
  head "https://github.com/grpc/grpc.git", branch: "master"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/grpc/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "63063e633cf1bf0a84d26b5dc0574d1d398c1309d9343e2e692be5cb84aa25d2"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "98ce451315e813dd28a8e648e5e867c39b654ec223ff71f777fcbe8f0466e680"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "77434d953f4d02e9a0f528736c9d1f427edc79d01703bb15a565c5018b5bcf11"
    sha256 cellar: :any_skip_relocation, sonoma:        "d682b2b1fc49ab3ccfbc73fe2d8fdf52c2dd042485586083d105b46d51c244c0"
    sha256 cellar: :any,                 arm64_linux:   "dbefb3833594966873be55bd737c6ac01ab94cd8a4612c3e8f441508e4c86fbb"
    sha256 cellar: :any,                 x86_64_linux:  "edc06b0d2a3d7271e1f279b3ac9c6089647c1586fedb021ff3461ba3a88f3245"
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
