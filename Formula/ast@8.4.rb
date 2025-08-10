# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Ast Extension
class AstAT84 < AbstractPhpExtension
  init
  desc "Ast PHP extension"
  homepage "https://github.com/nikic/php-ast"
  url "https://pecl.php.net/get/ast-1.1.3.tgz"
  sha256 "528b54aabcfce6bf0e94b5940a73cca357d4a52fad9fef4cd4dc025abc1a9fbd"
  head "https://github.com/nikic/php-ast.git", branch: "master"
  license "BSD-3-Clause"

  livecheck do
    url "https://pecl.php.net/rest/r/ast/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "1c98116e8c1e0e3254444d8392a9aeb58ec2d0371b3a117aff356a07f6696b3a"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "afb8a048f2aa742d56d0fed0d433144abe9a2a161728ac444d5cea353a606d2a"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "886a6ceba599d186831af296ef0d666cfc297982a6e79a8925d36a2014fc50b0"
    sha256 cellar: :any_skip_relocation, ventura:       "c910c9f27f70600ac1ce5b7037d9d691c197313de2f4d63bb6da81989bba7023"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "90de14f77d5fd498253bf50e470b823e0cd2195d07e6b263c7913464078677fd"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "3235104a950832dfdb2909b8c3ae02c294ea3900ba0d0e24b5070a6017a90fb9"
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
