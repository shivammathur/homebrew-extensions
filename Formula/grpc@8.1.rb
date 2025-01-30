# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT81 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.69.0.tgz"
  sha256 "85ef59edd3517b377736c49a73799ead4729a82b960474b8842c9f89d2fbf222"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "b621735af71592f10d1c4ce92b281190a73bfa47a8b47b2f0faa287ab1e956b6"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "b6a428d37e17a6556cdc00af02cfa483ad21e8d1149b43ea3bd646c934c34a2b"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "66f6607b7b709f0ac27965c8782b6a88c73d9f4383b2b7ccd5b8f6411f19cd58"
    sha256 cellar: :any_skip_relocation, ventura:       "8fb4a8ad2306eb69361bf9b244d25a7731dd2e99e7234254604200904551c591"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "7bb268f7afa752975d603836a55aefa855cd4ec21da07f7089fc1b0096350813"
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
