# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT83 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.63.0.tgz"
  sha256 "0d67d0935f1e4a1feabf96a64f24e32af1918cd09ea7bef89211520f938007ca"
  head "https://github.com/grpc/grpc.git", branch: "master"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "1f10bba56e5a3ac84797ee87595a20e895c30e22ee25ad07c059725b36ca8bdc"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "b052ccc85756fd37b42282a4d07e904cf3c8ccd4bbd8e08ee9e4f865ec698b14"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "c92b39f1363f72e6ff181f06880ee5c526295c4e7a1e595b44768dc55dcb7eb8"
    sha256 cellar: :any_skip_relocation, ventura:        "2fcc3bf80e1b8b02aeb4949d260e90e3a370ab64b84ada076b146d1440bcccf1"
    sha256 cellar: :any_skip_relocation, monterey:       "4d35b6fdb1c905635b8b0cfb4cbd220f1b0db8eab7d54cca1b663b84506843ee"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "e3c27c5ee2bfae0f206a42b6ff55ced032a8a19999449183ee85154a58493eaa"
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
