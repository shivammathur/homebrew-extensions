# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Ast Extension
class AstAT73 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "dda0d5b6871fbaef95c2d7fdfdedce916d757796fdd6ec10089593a76fe02529"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "df5163068f707df87175969bb323062ddf810b50907ccb6d1b9629dc0b5b578e"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "ae8b331893d3e2daa568dbc46373cbb2c24218e5bf3b187f6b864cdbb4971c89"
    sha256 cellar: :any_skip_relocation, sonoma:        "55cc66b6de64d2ee7f2837be6f58905b89552b02e3565f214655e5456f1d4273"
    sha256 cellar: :any_skip_relocation, ventura:       "d59e6e9ee971b40908c05578a025241f37fe3bcd4ed374e01a4b8f3c5c4add1a"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "3f7539450725896af4d3f3b3cf5fe888f72b835328db99648e9612d88fd622ba"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "5f65b38ccb9823eb2b25d131d96eadf3cb32f53a7292c98d3c9c7ae15eb25df1"
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
