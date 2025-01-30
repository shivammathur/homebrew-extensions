# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT74 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.69.0.tgz"
  sha256 "85ef59edd3517b377736c49a73799ead4729a82b960474b8842c9f89d2fbf222"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "1427f27f2951bae3ecf55df2e418b94dee9561ac878d117036ced642360f0c43"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "b9aa75efacc60b71e292e3e49f5c35e8984f7632b15ebaddf7902947241582fc"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "ae605f6f9c387b91f1426188e4c9ea3c16a735c3faac5a024c2a05189e0325df"
    sha256 cellar: :any_skip_relocation, ventura:       "b9db11f6368c4835cd2ee5ff48aac9399a28544ca74c55c90dcbb968cbe4f812"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "eacefed9397410b5ea513aeaa36b132be004ea0d2bbb435c3995ef674f52a467"
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
