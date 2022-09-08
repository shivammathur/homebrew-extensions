# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT72 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.48.1.tgz"
  sha256 "74e22f8eaf833e605e72ef77df3d432bc6d99647df532d972f161874053859e0"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "9f17367bdf0ab42a256cd8d3ce170bfe2da0d7717c3a5047e1c3f933f477cb1a"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "90dd820143a68a075361dd169c9c55d4658dd2fa004daa192798a9b0571ea0a1"
    sha256 cellar: :any_skip_relocation, monterey:       "5a69da4e33014172e19d4e12b8c06651d3ab77109cf18a1cca31face4c211f66"
    sha256 cellar: :any_skip_relocation, big_sur:        "1bba274e9013410a122f3bcf944d1dbf64243b684e36e967af2ba71ea5e4edf5"
    sha256 cellar: :any_skip_relocation, catalina:       "373ebadfc883f35b67410a942cde6bc1e8ebeef2e0defe4b68fdc8e45263c4b9"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "53e60074fdbe7d2573ae1a1ae99007352db5ad15a4e966a43e8aeaeab216c6f8"
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
