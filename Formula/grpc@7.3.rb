# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT73 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.49.0.tgz"
  sha256 "dfcd402553a53aac4894b65c77e452c55c93d2c785114b23c152d0c624edf2ec"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "5608c7bdd6f0ffb342a53490973b2a22c9a4af39c88697eb23f23067700edc5a"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "c7db68049e9c068147d118ac4d2640a8c0a163e1a1f48f4d92c25b31087fa9be"
    sha256 cellar: :any_skip_relocation, monterey:       "f9fd504326e8cf5525e184260d4c641505299615d29a48412def7aa5861657d6"
    sha256 cellar: :any_skip_relocation, big_sur:        "6eb0cbd6a26449e4fdf1ff9f9dbef28311e38ead8ef4e0cddc80336b75a7a27d"
    sha256 cellar: :any_skip_relocation, catalina:       "8476bd066c54c6df04f983f38cb6df8f65f115c131151c02d52eed891d043fa9"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "c3f74aeaeb492fed286054f20ad487ef1b4f8eba131689b103a7ac9eb3eb44df"
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
