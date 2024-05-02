# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT81 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.63.0.tgz"
  sha256 "0d67d0935f1e4a1feabf96a64f24e32af1918cd09ea7bef89211520f938007ca"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "c8ab80546ee91e10be7639f260ef1dc876d359805937ef8b29ce7be9fefc03da"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "5a80d188ee870ffeb676035ccbb910cef3f06a4ff7ecbd8f64dd97cd5720fe8d"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "c3b1f013662e901aa21222b05f1b27a099b5f664bc44cf25dcaff10ee9d247d4"
    sha256 cellar: :any_skip_relocation, ventura:        "f48b1554509f5fbc009748e57283adaed483616db33fc0016b6243f8f09d0577"
    sha256 cellar: :any_skip_relocation, monterey:       "d2795e70e283863bae974ebb136faa7018e0bbed4b72c813853f294361eea719"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "605a9ffa0b72bc28262b56d73318ce583f30777b075dcb2882078985be000bc6"
  end

  depends_on "grpc"

  def install
    Dir.chdir "grpc-#{version}"
    patch_spl_symbols
    safe_phpize
    system "./configure", "--enable-grpc"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
