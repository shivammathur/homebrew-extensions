# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Interbase Extension
class InterbaseAT70 < AbstractPhpExtension
  env :std

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any,                 arm64_tahoe:   "285d14f485cc8ade562c0d554eeda757ef6c5b1e7f7f43c7f81792a9c3f04ae6"
    sha256 cellar: :any,                 arm64_sequoia: "b435cb324851bd851a1452da4945e1930ca8d8e175b040316a55143788e7499e"
    sha256 cellar: :any,                 arm64_sonoma:  "1587439e917b52f1e1af9b07bee8c26414b926ec287511fa83929622326aa43d"
    sha256 cellar: :any,                 sonoma:        "05c86327ba8cd906668858edbd4d5b62abc85e2c5b9b2b34ff8ff92bafbd19ce"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "303279a9bb68e0f098b3dadc91c34016c8ff9e97b19504d6c495b9a4da6c2289"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "ef14a1651f8a936abc90f20ddf8e378df98fbaa58b39b7734f3954b44d5dd29e"
  end
  init
  desc "Interbase (Firebird) PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/29e84585e66b01b94f8dc0059dedcc8c55820018.tar.gz"
  version "7.0.33"
  sha256 "87e056213c805ea6c4e6f5527dfa526bbdc74e93d4e64d2d972eb3dd33aa6ba0"
  license "PHP-3.01"

  depends_on "shivammathur/extensions/firebird-client@3"

  def install
    fb_prefix = Utils::Path.formula_opt_prefix("shivammathur/extensions/firebird-client@3")
    args = %W[
      --with-interbase=shared,#{fb_prefix}
    ]
    Dir.chdir buildpath/"ext/interbase" do
      safe_phpize
      system "./configure", "--prefix=#{prefix}", phpconfig, *args
      system "make"
      prefix.install "modules/#{extension}.so"
      write_config_file
      add_include_files
    end
  end
end
