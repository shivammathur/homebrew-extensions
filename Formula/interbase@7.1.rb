# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Interbase Extension
class InterbaseAT71 < AbstractPhpExtension
  env :std

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 2
    sha256 cellar: :any, arm64_tahoe:   "0795fa40e3e817cdff829695999cb6bef8a30512ad54a5d99e8eb1f84faa05fb"
    sha256 cellar: :any, arm64_sequoia: "bac5f37cacdd7173f9d5a5efe2558e55f429d34e2094aa10b7c94cb3c538d9b2"
    sha256 cellar: :any, arm64_sonoma:  "cd7ceb2d4c39fd537faa412f53579b66c6a2def0d59ce1f0db3812d18fa00738"
    sha256 cellar: :any, sonoma:        "f7a5d58bc5a11f0d17da1afdd4a4e03328ec9a9176bd3751a60d70650bdb6999"
    sha256 cellar: :any, arm64_linux:   "333de18e2e986c11671fa4e14c6d534aa65c40e94fe4d8e4130cae6e5c060e22"
    sha256 cellar: :any, x86_64_linux:  "d0196924471af10f57f3b3e154834752e28ea99eb95eabd55f51058b179e8781"
  end
  init
  desc "Interbase (Firebird) PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/dca4c0c085063632757e8f8d296e06aaff2159e9.tar.gz"
  version "7.1.33"
  sha256 "c16d623df64f5f4823b15880350923498ec0003af815a8c121a53b8755e14914"
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
