# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT84 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.70.0.tgz"
  sha256 "11336d7bc4465148db506348006dd5559ce478eee4bf1b080bb31b89de6974b7"
  head "https://github.com/grpc/grpc.git", branch: "master"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "a7e74afefa95fd43c5044f83f5031fa69cac46b38f68c5c0efeacf8e0c27dc34"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "6d49271008d918ce05ada21a0d4b47635bc1502499c63a89cc299c15051a3503"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "1930fa92b5a30f3fb54ce8e29fb4bfa83fdaca5244a5ae6cefcfe8d467fd6013"
    sha256 cellar: :any_skip_relocation, ventura:       "13a1075ca68ade2361e4b473038d0dfb09ce2694fe282a834ed1b8e414d9f4cb"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "295086b38e6cad93a8f7283e1d513e2f00e0dfdfb7587b2db765d7161166d8e0"
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
