# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT70 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.69.0.tgz"
  sha256 "85ef59edd3517b377736c49a73799ead4729a82b960474b8842c9f89d2fbf222"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "2b26b99a942bab3c22ba5d784cb836ea7f89e6af5008ff633f9886709a0ddaaf"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "e8ec69d5728c9abb8baaa58461823310654d242573b08568c1b6b77fce0950de"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "bbe149e0743201c7befd83384efd44f306cb40921781f6767e0e9b6eee9d202b"
    sha256 cellar: :any_skip_relocation, ventura:       "cc988e62deabebb4a894f221752f8aee48bfcf2b37946b56054c36df964a0b6d"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "8615a95a3396735ebe7b76a64bc2163c250652f37a3409259d04f97450952bc9"
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
