# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT56 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.33.1.tgz"
  sha256 "aa26eb1fb0d66216f709105d2605a8a72b20407076d1e9bb0bd7cb17a277582c"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:  "56f0064c8d1a7abe79c0744a5a1764ab0a257dcc911d12cb6121d06dedcf0d90"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "12b2f5286ef30ad622cea2ec7d73b572a90af3d1791ff54135c2794235221ae9"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "986c0e4d9da292ae337fa80f10510b4d0a6dcd2e05475a855468bd104e123aa3"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "308cd8002c7140a2580511261a6d72fd498eb0a8380be4690e1155dfdfd31ab9"
    sha256 cellar: :any_skip_relocation, sonoma:         "fbb1b6e48108fe447bd11f281d610ac4d6ea7d83734a01f78fa5060987ec7f4b"
    sha256 cellar: :any_skip_relocation, ventura:        "5d6fcc7641e12281b9e3249e928fe5c9e5dbf4e6a95d4aa962cb04c314d63e04"
    sha256 cellar: :any_skip_relocation, big_sur:        "f622cc6a4a7765f6801cea51606bb654c85b856ff3c967c0bce38221690123ee"
    sha256 cellar: :any_skip_relocation, catalina:       "a4bea154f0ed31c4f4fe7beb6f3cbe467057a7aad4a44f9db9f1e2c6c545f178"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "e7ca2de6afe26ac0a6f712e6a7c8f3db7509aad38315febf0e9ee5fca12a5b95"
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
