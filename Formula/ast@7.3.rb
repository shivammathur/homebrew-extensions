# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Ast Extension
class AstAT73 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_golden_gate: "87402a9142b5ca48a8b5f35e0aac29be0c167721ef10679418d9bc5444a94f9e"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:       "5c826b954f86a55b2797c9a0d0ad6c6848dd7ff48f9636742b3440325bac1eab"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:     "3266cd85612de9173a59990181aeb842f92439760ec4aea9de525c0f80800e75"
    sha256 cellar: :any,                 arm64_linux:       "71f31e1ae3904459271b5eff91d1405e2f4c89e4208c6fecac094b53e2c84207"
    sha256 cellar: :any,                 x86_64_linux:      "d61bde74b20914dca220c27d9644e5f6d77421aa20008e58990a8067a0c44db5"
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
