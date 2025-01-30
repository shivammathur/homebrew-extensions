# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT72 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.69.0.tgz"
  sha256 "85ef59edd3517b377736c49a73799ead4729a82b960474b8842c9f89d2fbf222"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "90601cd541cf618307d0733433e9d4e4c530b930c23935340eea65a16728d487"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "e2f9ae91832918c4b8bac0aabec24a4aff01dc0273ff45aecfe5c6131aed89b6"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "bd959dc87a6cef7c906bad98642d3c23dcf1d9631d00fe95b9161022a0cccc9d"
    sha256 cellar: :any_skip_relocation, ventura:       "44aebcddbe11eb3a216dc39b92b1dd531a15d634033a76edd154eeb47e0501c0"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "185582cf1046cfcaabb622ffb5897f72bcd8de4d25f3eee83c94703f975ae4ec"
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
