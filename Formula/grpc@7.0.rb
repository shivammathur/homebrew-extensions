# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT70 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.52.1.tgz"
  sha256 "f8ce3ec8ab3678c70d57fe60982dcb6562a6cc162718cfbe74783915b49803c4"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "c8b108c33fea8f45ea9e1617830ded009b98a5a9c7dec6267a88984177d62f6e"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "cad7d34b02ebaddde79193e95802ea92faa467018617f40fc1ff7e82f4d830b1"
    sha256 cellar: :any_skip_relocation, monterey:       "9cc9f2d7f01f385ea9444b8cf2e56a054f392d5207c92e2e33df143dbd2ac888"
    sha256 cellar: :any_skip_relocation, big_sur:        "2a12974dd1bb90c2c8965c3e0e4baa9b1d5248f1e39dfe02f6dcc59dcb234491"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "b1c191efb51e1aa716d29f844e9e57855f2a4809ebdef86e6cd7863de324836a"
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
