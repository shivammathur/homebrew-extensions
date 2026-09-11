# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Maxminddb Extension
class MaxminddbAT86 < AbstractPhpExtension
  init
  desc "MaxMind DB Reader PHP extension"
  homepage "https://github.com/maxmind/MaxMind-DB-Reader-php-ext"
  url "https://pecl.php.net/get/maxminddb-1.14.0.tgz"
  sha256 "c06351f1360bd651057ea73e0186d8fec744292839a4b49c71ce886072c4fff7"
  head "https://github.com/maxmind/MaxMind-DB-Reader-php-ext.git", branch: "main"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/maxminddb/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_tahoe:   "c0aa51d08df337b8e7dc2ec194ff8d293571442ac77bc15cb6d5c31987dd26f0"
    sha256 cellar: :any, arm64_sequoia: "e7d465b63edef1c0b987ad4aec84bfebcde739f69b6a15da4b4120b12c4c0cbf"
    sha256 cellar: :any, arm64_sonoma:  "0b606da4b300907578e2742e7c5e5e52eb962c55cee502736032ff81e7c3f371"
    sha256 cellar: :any, arm64_linux:   "d6b1773ab3fa67d5c3e2ba63ceefbe9bec55d2a54b0f8c774026a64221db7033"
    sha256 cellar: :any, x86_64_linux:  "20fe871b3f1bc148f6b1fca38f140f24a1ee18c4e7adb658ddd01296f4c51af2"
  end

  depends_on "libmaxminddb"

  def install
    Dir.chdir "maxminddb-#{version}/ext"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--with-maxminddb"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
