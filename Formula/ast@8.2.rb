# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Ast Extension
class AstAT82 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_golden_gate: "54c5766af1c38ee425416cb437b143bd8bedc48fdb061458b3f0ccdfa2c9389e"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:       "76ede412d97d4f3f3e1a9015118586d3d11f102344f564337becc31a5f7bf250"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:     "fa230090b18c95b36a2bf75affea77edd8044adcf3954d7baf1d714bcc3c6d3c"
    sha256 cellar: :any,                 arm64_linux:       "2e815c84fdcfc2e7190671a4ca2126fa7f578016495bb36adc73bc3c583e46aa"
    sha256 cellar: :any,                 x86_64_linux:      "8dfb7cd0dcbaff43feea1ecfc8b3e1fa547ce1171672b1e998ce78a79b147798"
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
