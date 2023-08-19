# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Ast Extension
class AstAT83 < AbstractPhpExtension
  init
  desc "Ast PHP extension"
  homepage "https://github.com/nikic/php-ast"
  url "https://pecl.php.net/get/ast-1.1.0.tgz"
  sha256 "ee3d4f67e24d82e4d340806a24052012e4954d223122949377665427443e6d13"
  head "https://github.com/nikic/php-ast.git", branch: "master"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_monterey: "4c81bed0318800dfafab253a64c376c0a0931ba6a3e255df5d974b5150dc1322"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "47d7e2147bbd6ddfd52238dc389df5369c2a171f56386acd7275a76b072d6f36"
    sha256 cellar: :any_skip_relocation, ventura:        "04128cb16f70902e33986be844e36f13359b172dcff0d35b9aefab2067930855"
    sha256 cellar: :any_skip_relocation, monterey:       "d24caf68f453ae43020fad8fb9fadb1183aa76cd72752f6e80854b661a80e431"
    sha256 cellar: :any_skip_relocation, big_sur:        "fb81fda0e06e02d48355e5434b665674aff504510fa9a4025bad306a89d5be87"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "1282e24612661c8413657546250eb24947be1646eae76e55b1d885a87e80c0b4"
  end

  def install
    Dir.chdir "ast-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-ast"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
