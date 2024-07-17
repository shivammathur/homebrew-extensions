# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT80 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.65.1.tgz"
  sha256 "78d14477f19793ac7b617bce8f8795b7f6b8888f338316f96eade83156e58e7a"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "da0d79cb3a730f34d15795c0dc3654f85bbd51b4b7446895b1147528c3bc0e51"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "b81f3fe5176321b3967be3a6c33f28c5be56e8c77db2fdfafd84fdd7bd1fe71a"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "25ddf9cba209cb7b371cc8243367783cd30305900bbbdaca3023f68b168debf5"
    sha256 cellar: :any_skip_relocation, ventura:        "d88da45109ba4f337b200bfdbf4c364bacf134fe54086723d143f799618d6d74"
    sha256 cellar: :any_skip_relocation, monterey:       "20a24d57fb24254093db2d13787aaac2c7ecc9d571a758c626ff78a193ec0dd3"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "6a43d49b5b647d8c52e1013162ef6c300fc6fc46f2ac3904f4fc77bf03e894fb"
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
