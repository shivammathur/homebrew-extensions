# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT73 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.69.0.tgz"
  sha256 "85ef59edd3517b377736c49a73799ead4729a82b960474b8842c9f89d2fbf222"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "2995a4bca5c20905d97d0a5564c0632aa2b7b15bfb643fa0bc2a2ed5561093e0"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "29969ff9e0f4a308c1c156d0a2f45880245b6f7ee934a6305698190d498a6182"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "a7def126dfa7539d9715b5761b581a968cdabb911fd079c9832c8bd9526c62a8"
    sha256 cellar: :any_skip_relocation, ventura:       "93caaf8faa31df9808e0ea09b78c064c283726eb8b27848fde13fef804c516fb"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "83f93fbd26148cd261544a4fe5f66b78be750d99d11877dceab4862460f26975"
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
