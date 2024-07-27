# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT74 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.65.2.tgz"
  sha256 "5efbfd399f3be464e293bb0ec4a773fae9bb4a43b67362e1fac72bb4cae4bbc3"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "4e9e799245143e6f21598e892982f912f700e9de227e62a5cac686041c29d2b2"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "20572edfb52d52241fd1e3a00b7665afa1493c7fe01eeddb8b95874dd0bc06fb"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "61a4c0ec82b908a721962b1c05df9e4ec3f9ffa2768ee1b8245c7d82697a9f42"
    sha256 cellar: :any_skip_relocation, ventura:        "78a814fd2bddcf40d540a22774fc498b76e94c03d0864c68a4380fccb967c46e"
    sha256 cellar: :any_skip_relocation, monterey:       "83f089ded66f90f5ee0efa1d2250ee4b12c93a008f1c73f15742839ed4606487"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "73d08e03cfb15a26421f8b9624556d6d6adf355195032f9a6728df42361e7b7f"
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
