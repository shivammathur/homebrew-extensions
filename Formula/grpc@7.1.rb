# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT71 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.37.1.tgz"
  sha256 "2abefeea06491ac76862bacf16e78732ffbf4ffb0b0e4f74263d4f1a5c7745d6"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "b3b655758f416c90a9a9e291a16b63140c21cbec865b3fd3d627152d344bc5e0"
    sha256 cellar: :any_skip_relocation, big_sur:       "1fee4aa897b5b166e5e0ec54a8e139013b33ae470f5addf88b960a24af58e3ab"
    sha256 cellar: :any_skip_relocation, catalina:      "b08ce70463200e4bde928bd6ab3299c52026a49da4ab2a21a61f0ee19d684e3a"
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
