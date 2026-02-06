# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Uploadprogress Extension
class UploadprogressAT81 < AbstractPhpExtension
  init
  desc "Uploadprogress PHP extension"
  homepage "https://github.com/php/pecl-php-uploadprogress"
  url "https://pecl.php.net/get/uploadprogress-2.0.2.tgz"
  sha256 "2c63ce727340121044365f0fd83babd60dfa785fa5979fae2520b25dad814226"
  head "https://github.com/php/pecl-php-uploadprogress.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/uploadprogress/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "98325fa021a843361e4a987c3fa0727ee42460815f6b19d983aa77455b2340a2"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "8867dc595058a7520e735f024cd3a5672a7b42582f36122dd0b907988070d641"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "7988ee3be0e8eccf6c07190d3e6ca103b79bdc64c34a9b7b8020bde229072dc2"
    sha256 cellar: :any_skip_relocation, sonoma:        "eff83ba51054a764760c9a897d0c34e16bc333aabe013348e60391769f40677b"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "f36a6dfea15b009bd3276f27d3a12ec5580fdbf4762edb99224245539691ccc4"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "ae6ce5118f189e44f831414bfe104f2819bb8826f2d6a8d1e4c0c0a1f537a128"
  end

  def install
    Dir.chdir "uploadprogress-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-uploadprogress"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
