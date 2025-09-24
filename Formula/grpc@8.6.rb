# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT86 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.75.0.tgz"
  sha256 "d2fa2d09bb12472fd716db1f6d637375e02dfa2b6923d7812ff52554ce365ba1"
  head "https://github.com/grpc/grpc.git", branch: "master"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/grpc/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "0c1bc0021511d63b16647b0f614d6f49ac8ed28345043cf17c5a8912a358f701"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "5a599be8ae7663478e348b65556830a4daa3db8568520962df1e3707f24d9ae7"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "d4948ee2e4980531dff73ee16c1e6df9ddb66ca68fa20c69c94c69aae4ee2d23"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "eec5edb2dce4b19780f5c47ce28795e0278e2422fc0fa2c893e73ae5e6f33acd"
  end

  depends_on "grpc"

  def install
    Dir.chdir "grpc-#{version}"
    patch_spl_symbols
    inreplace "src/php/ext/grpc/call.c", "zend_exception_get_default(TSRMLS_C)", "zend_ce_exception"
    safe_phpize
    system "./configure", "--enable-grpc"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
