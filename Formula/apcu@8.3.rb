# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Apcu Extension
class ApcuAT83 < AbstractPhpExtension
  init
  desc "Apcu PHP extension"
  homepage "https://github.com/krakjoe/apcu"
  url "https://pecl.php.net/get/apcu-5.1.24.tgz"
  sha256 "5c28a55b27082c69657e25b7ecf553e2cf6b74ec3fa77d6b76f4fb982e001e43"
  head "https://github.com/krakjoe/apcu.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:  "0f44484905165b0460c35770610747470ad63451d4f32fdcfc3a43b27b10158a"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "b803ce2787a7d37556b12fcd48ee96d361ba9b226871793ea0540e05e31c644a"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "57aaec5abfbbe44d50d25209f635f325e5736024b859cf16ca2215dda328f0de"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "ff8a88e8b9b67c067633cc6d7297be3e4a302d2a7f52e69a678d16909d4ab00d"
    sha256 cellar: :any_skip_relocation, ventura:        "091a80943be650b0eebe5171fa883f6d50a615cc4b6677a16d632efb5119f8bf"
    sha256 cellar: :any_skip_relocation, monterey:       "89cb2efa46bde69bcc95eba6b4d80a8e72d005dab3d8bc9847abb14988148409"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "5750985adb4e002c8b601eee3f3979f4649d9f0c308826bda616efe004627347"
  end

  def install
    Dir.chdir "apcu-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-apcu"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
