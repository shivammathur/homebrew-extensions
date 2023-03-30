# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT74 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.53.0.tgz"
  sha256 "10b214a785205bf8c5b3b8ebbeeddfdabce63a9c44399f250ba26763ae5646ab"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "5eccdc9a11aeb6922cf091cdcf18226ec6598e1fa271162c0670117666a32a34"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "723bafbccba85fc64777c0df0ccee7abef236d5dbe404f6f6d9a5e1aa6dc31dd"
    sha256 cellar: :any_skip_relocation, monterey:       "3a3e9c71b92415dd2fd4e2da9aa6b58e8c548a3d6a1293b9fd3ac9ff050c819c"
    sha256 cellar: :any_skip_relocation, big_sur:        "f548d26aa5d8cab637529f29110c458240714bf47858addfe0721a11078f551d"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "f11fd150f42293ed2a3efb20a530f36899b617b5717708372901edbde1664590"
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
