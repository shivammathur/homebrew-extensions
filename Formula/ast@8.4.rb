# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Ast Extension
class AstAT84 < AbstractPhpExtension
  init
  desc "Ast PHP extension"
  homepage "https://github.com/nikic/php-ast"
  url "https://pecl.php.net/get/ast-1.1.4.tgz"
  sha256 "28728fb8bfd8b0eddccd241f92f0be0a45d83250e5a0cd6e1876c0c533ab3658"
  head "https://github.com/nikic/php-ast.git", branch: "master"
  license "BSD-3-Clause"

  livecheck do
    url "https://pecl.php.net/rest/r/ast/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_golden_gate: "145e5e5b456049b7a8ecd7538660cbd32294f42fdce4f169de4ff1abd7350691"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:       "f1920b22220cb7c03bad3286fb042818866ff9eecea3ba95fc9c322df0f7659a"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:     "1e235dd33bb65e111478e8bc6f59f9e33f31a26337c73e2d0162cbfb634a90ba"
    sha256 cellar: :any,                 arm64_linux:       "a2982b0494b1da4af3f1cc9c3209c8e111ec021777d9e2b15a45d41d4eedb08f"
    sha256 cellar: :any,                 x86_64_linux:      "cd4dc2c857a89f9b665cceecf3c739acf0f2dec7fd38eef56e0fe403eed88f6c"
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
